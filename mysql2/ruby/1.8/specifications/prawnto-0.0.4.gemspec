# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{prawnto}
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["smecsia"]
  s.date = %q{2010-11-10}
  s.email = %q{smecsia@gmail.com}
  s.extra_rdoc_files = ["README"]
  s.files = ["Rakefile", "README", "MIT-LICENSE", "lib/prawnto/template_handler/compile_support.rb", "lib/prawnto/template_handlers/dsl.rb", "lib/prawnto/template_handlers/raw.rb", "lib/prawnto/template_handlers/base.rb", "lib/prawnto/action_controller_mixin.rb", "lib/prawnto/action_view_mixin.rb", "lib/prawnto/railtie.rb", "lib/prawnto.rb", "test/base_template_handler_test.rb", "test/template_handler_test_mocks.rb", "test/raw_template_handler_test.rb", "test/dsl_template_handler_test.rb", "test/action_controller_test.rb", "rails/init.rb"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Prawnto rails plugin implemented as a gem (see prawnto)}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 2.1"])
      s.add_runtime_dependency(%q<prawn>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 2.1"])
      s.add_dependency(%q<prawn>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 2.1"])
    s.add_dependency(%q<prawn>, [">= 0"])
  end
end
