#!/usr/bin/env ruby
# typed: true

require 'pp'
require 'sorbet-runtime'

include T::Sig

rules, updates = STDIN.read.split("\n\n")
rules = T.must(rules).split("\n").map{|r|r.strip}
updates = T.must(updates).split("\n").map{|u|u.strip}

rule_regexes = rules.map do |rule|
    rule_pre, rule_post = rule.split("|")
    rule_regex = Regexp.new(/\b#{rule_pre}\b.*?\b#{rule_post}\b/)
    [rule_regex, Regexp.new(/\b#{rule_pre}\b/), Regexp.new(/\b#{rule_post}(\b|$)/)]
end

real_updates = updates.select do |update|
    rule_regexes.all? do |(rule_regex, pre, post)|
        !update.match?(pre) || !update.match?(post) || update.match?(rule_regex)
    end
end

sum = real_updates.sum{|u| s=u.split(",");s[s.length / 2].to_i}

puts "sum: #{sum.pretty_inspect}"  # XX