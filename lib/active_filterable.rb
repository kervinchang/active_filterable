# frozen_string_literal: true

require_relative "active_filterable/version"

module ActiveFilterable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def filterable(*columns, by: [])
      columns.each do |column|
        by.each do |filter|
          scope "#{column}_#{filter}", ->(value) { filter_query(column, filter, value) }
        end
      end

      define_singleton_method(:filter_by) do |filters|
        query = self
        filters.each_key do |filter|
          value = filters[filter]
          query = query.and(send(filter, value))
        end
        query
      end
    end

    def filter_query(column, filter, value)
      return if value.blank?

      case filter
      when :eq, :in
        where(column => value)
      when :lt
        where("#{column} < ?", value)
      when :gt
        where("#{column} > ?", value)
      when :le
        where("#{column} <= ?", value)
      when :ge
        where("#{column} >= ?", value)
      when :ne, :not_in
        where.not(column => value)
      when :start_with
        where("#{column} LIKE ?", "#{value}%")
      when :like
        where("#{column} LIKE ?", "%#{value}%")
      when :end_with
        where("#{column} LIKE ?", "%#{value}")
      end
    end
  end
end
