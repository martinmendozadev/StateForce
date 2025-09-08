#!/usr/bin/env ruby
# Collate SimpleCov resultsets and regenerate cobertura XML.
begin
  require 'simplecov'
  require 'simplecov-cobertura'
  SimpleCov.root(File.expand_path('.', Dir.pwd))
  resultsets = Dir['coverage/.resultset*json']
  puts "Collating: #{resultsets.join(', ')}"
  if resultsets.empty?
    puts 'No resultset files to collate'
    exit 0
  end
  SimpleCov.collate(resultsets, 'rails') do
    SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
      SimpleCov::Formatter::HTMLFormatter,
      SimpleCov::Formatter::CoberturaFormatter
    ])
  end
rescue LoadError => e
  puts "SimpleCov not available: #{e.message}"
  exit 0
rescue => e
  puts "SimpleCov collate failed: #{e.class}: #{e.message}"
  puts e.backtrace.join("\n")
  exit 0
end
