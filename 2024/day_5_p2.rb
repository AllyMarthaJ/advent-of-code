#!/usr/bin/env ruby
# typed: true

require 'pp'
require 'sorbet-runtime'

include T::Sig

rules, updates = STDIN.read.split("\n\n")
rules = T.must(rules).split("\n").map{|r|r.strip}
updates = T.must(updates).split("\n").map{|u|u.strip}.to_set

rule_regexes = rules.map do |rule|
    rule_pre, rule_post = rule.split("|")
    rule_regex = Regexp.new(/\b#{rule_pre}\b.*?\b#{rule_post}\b/)
    [rule_regex, Regexp.new(/\b#{rule_pre}\b/), Regexp.new(/\b#{rule_post}(\b|$)/), T.must(rule_pre), T.must(rule_post)]
end

real_updates = updates.select do |update|
    rule_regexes.all? do |(rule_regex, pre, post, pre_v, post_v)|
        !update.match?(pre) || !update.match?(post) || update.match?(rule_regex)
    end
end.to_set

fixers = updates - real_updates

fixed = fixers.map do |to_fix|
    to_fix = to_fix.dup
    loop do
        should_break = T.let(true, T::Boolean)
        rule_regexes.each do |(rule_regex, pre, post, pre_v, post_v)|
            next if !to_fix.match?(pre) || !to_fix.match?(post) || to_fix.match?(rule_regex)

            to_fix.gsub!(pre, "tmp")
            to_fix.gsub!(post, pre_v)
            to_fix.gsub!("tmp", post_v)
            should_break = false
        end
        break if should_break
    end
    to_fix
end

# puts "fixed: #{fixed.pretty_inspect}"  # XX

sum = fixed.sum{|u| s=u.split(",");s[s.length / 2].to_i}

puts "sum: #{sum.pretty_inspect}"  # XX