# frozen_string_literal: true

name 'vagrant'
default_source :supermarket

run_list 'test::default'

cookbook 'vagrant', path: '.'
cookbook 'test', path: './test/cookbooks/test'
cookbook 'wintest', path: './test/cookbooks/wintest'
