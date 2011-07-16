# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{excon}
  s.version = "0.6.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["geemus (Wesley Beary)"]
  s.date = %q{2011-04-11}
  s.description = %q{EXtended http(s) CONnections}
  s.email = %q{geemus@gmail.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["Gemfile", "README.rdoc", "Rakefile", "benchmarks/class_vs_lambda.rb", "benchmarks/concat_vs_insert.rb", "benchmarks/concat_vs_interpolate.rb", "benchmarks/cr_lf.rb", "benchmarks/downcase-eq-eq_vs_casecmp.rb", "benchmarks/excon_vs.rb", "benchmarks/for_vs_array_each.rb", "benchmarks/for_vs_hash_each.rb", "benchmarks/has_key-vs-hash[key].rb", "benchmarks/headers_case_sensitivity.rb", "benchmarks/headers_split_vs_match.rb", "benchmarks/implicit_block-vs-explicit_block.rb", "benchmarks/merging.rb", "benchmarks/string_ranged_index.rb", "benchmarks/strip_newline.rb", "benchmarks/vs_stdlib.rb", "changelog.txt", "excon.gemspec", "lib/excon.rb", "lib/excon/connection.rb", "lib/excon/errors.rb", "lib/excon/response.rb", "tests/basic_tests.rb", "tests/proxy_tests.rb", "tests/query_string_tests.rb", "tests/rackups/basic.ru", "tests/rackups/proxy.ru", "tests/rackups/query_string.ru", "tests/rackups/thread_safety.ru", "tests/stub_tests.rb", "tests/test_helper.rb", "tests/thread_safety_tests.rb"]
  s.homepage = %q{https://github.com/geemus/excon}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{excon}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{speed, persistence, http(s)}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<open4>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<shindo>, ["= 0.2.0"])
      s.add_development_dependency(%q<sinatra>, [">= 0"])
    else
      s.add_dependency(%q<open4>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<shindo>, ["= 0.2.0"])
      s.add_dependency(%q<sinatra>, [">= 0"])
    end
  else
    s.add_dependency(%q<open4>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<shindo>, ["= 0.2.0"])
    s.add_dependency(%q<sinatra>, [">= 0"])
  end
end
