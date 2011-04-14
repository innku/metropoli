# -*- encoding: utf-8 -*-
require 'helper'

class TestState < ActiveSupport::TestCase
  include Metropoli
  extend Shoulda::ActiveRecord::Matchers

  def setup
    @yucatan         = StateModel.find_by_name('Yucatán')
    @nuevo_leon      = StateModel.find_by_name('Nuevo León')
    @shoulda_subject = StateModel.new
  end

  should belong_to(:country)
  should have_many(:cities).dependent(:destroy)

  context 'quering states' do
    should 'find states by name' do
      assert_equal [@yucatan],     StateModel.like('Yucatán')
      assert_equal [@nuevo_leon],  StateModel.like('Nuevo León')
    end

    should 'find states with incomplete name' do
      assert_equal [@yucatan], StateModel.like('yuc')
    end

    should 'return all states with empty query' do
      assert_equal StateModel.count, StateModel.like('').count
    end

    should 'should return all states with blank query' do
      assert_equal StateModel.count, StateModel.like('').count
    end

    context 'finding by string' do
      should 'find city by its string representation' do
        assert_equal [@yucatan], StateModel.by_string(@yucatan.to_s)
        assert_equal [@yucatan], StateModel.by_string("Yucatán")
      end

      should 'use autocomplete fields' do
        assert_equal [@yucatan], StateModel.by_string('Yucatán, MX')
      end

      should 'not allow incomplete names' do
        assert_equal 0, StateModel.by_string('Yuca, MX').count
        assert_equal 0, StateModel.by_string('Yucatán, M').count
      end

      should 'not return no results if passing blank' do
        assert_equal 0, StateModel.by_string('').count
        assert_equal 0, StateModel.by_string(nil).count
      end
    end

    context 'autocomplete' do
      should 'find states without country' do
        assert_equal [@nuevo_leon], StateModel.autocomplete('Nuevo León')
      end

      should 'find states with country' do
        assert_equal [@nuevo_leon], StateModel.autocomplete('Nuevo León, MX')
      end

      should 'find states with country full name' do
        assert_equal [@nuevo_leon], StateModel.autocomplete('Nuevo León, México')
        assert_equal [@nuevo_leon], StateModel.autocomplete('Nuevo Le, México')
      end

      should 'find states with ascii name' do
        assert_equal [@nuevo_leon], StateModel.autocomplete('Nuevo Leon, México')
      end

      should 'find states with alternate name' do
        assert_equal [@nuevo_leon], StateModel.autocomplete('Estado de Nuevo León, México')
      end

      should 'scope state with provided country' do
        assert_equal 0, StateModel.autocomplete('Monterrey, BO').count
      end

      should 'return all states with blank' do
        assert_equal StateModel.count, StateModel.autocomplete('').count
      end

      should 'return all states with nil' do
        assert_equal StateModel.count, StateModel.autocomplete(nil).count
      end
    end
  end
  
  context 'representations' do
    should 'emit json' do
      assert_equal %({"state":{"id":#{@nuevo_leon.id},"to_s":"Nuevo Le\\u00f3n, Mexico"}}), @nuevo_leon.to_json
    end

    should 'have custom format for #to_s' do
      assert_equal "Nuevo León, Mexico", @nuevo_leon.text
      assert_equal "Nuevo León, Mexico", @nuevo_leon.to_s
    end
  end
end
