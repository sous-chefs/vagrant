# frozen_string_literal: true

name 'vagrant'
default_source :supermarket

run_list 'test::default'

named_run_list :generic, 'test::generic'
named_run_list :uninstall, 'test::default', 'test::uninstall'
named_run_list :generic_uninstall, 'test::generic', 'test::genericuninstall'

cookbook 'vagrant', path: '.'
cookbook 'test', path: './test/cookbooks/test'
cookbook 'wintest', path: './test/cookbooks/wintest'
