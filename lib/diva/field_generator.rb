# -*- coding: utf-8 -*-

class Diva::FieldGenerator
  def initialize(model_klass)
    @model_klass = model_klass
  end

  def int(field_name, options = {})
    options = {required: false}.merge(options)
    @model_klass.add_field(field_name, type: :int, required: options[:required])
  end

  def string(field_name, options = {})
    options = {required: false}.merge(options)
    @model_klass.add_field(field_name, type: :string, required: options[:required])
  end

  def bool(field_name, options = {})
    options = {required: false}.merge(options)
    @model_klass.add_field(field_name, type: :bool, required: options[:required])
  end

  def time(field_name, options = {})
    options = {required: false}.merge(options)
    @model_klass.add_field(field_name, type: :time, required: options[:required])
  end

  def uri(field_name, options = {})
    options = {required: false}.merge(options)
    @model_klass.add_field(field_name, type: :uri, required: options[:required])
  end

  def has(field_name, type, options = {})
    options = {required: false}.merge(options)
    @model_klass.add_field(field_name, type: type, required: options[:required])
  end
end








