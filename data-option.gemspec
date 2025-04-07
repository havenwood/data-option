# frozen_string_literal: true

require_relative 'lib/data/option/version'

Gem::Specification.new do |spec|
  spec.name = 'data-option'
  spec.version = Data::Option::VERSION
  spec.authors = ['Shannon Skipper']
  spec.email = ['shannonskipper@gmail.com']

  spec.summary = 'Option classes for Some and None'
  spec.description = 'Some and None Option classes with Rust-like semantics'
  spec.homepage = 'https://github.com/havenwood/data-option'
  spec.required_ruby_version = '>= 3.4.0'
  spec.license = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['rubygems_mfa_required'] = 'true'

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |filename|
      (filename == gemspec) || filename.start_with?(*%w[test/ .git Gemfile])
    end
  end
end
