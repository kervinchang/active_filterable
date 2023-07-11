# ActiveFilterable

ActiveFilterable is a gem designed to enable custom query filters for ActiveRecord models through metaprogramming. By using ActiveFilterable, you can specify which attributes of a model can be used for filtering and define different query methods such as full-text matching, prefix matching, suffix matching, IN queries, NOT IN queries, equality, greater than, less than, not equal, greater than or equal to, and less than or equal to.

ActiveFilterable provides a concise and flexible way to handle complex query requirements. It allows you to define query filters directly in the model and apply them by chaining method calls in the controller, generating the corresponding query conditions.



## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add active_filterable

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install active_filterable

## Usage

1. In your Rails application, include the ActiveFilterable module in the model where you want to add the filtering functionality.

   ```ruby
   include ActiveFilterable
   ```

2. Use the `filterable` method in the model to define filters.

   ```ruby
   filterable :column1, :column2, by: [:filter1, :filter2]
   ```

   This method accepts two parameters:

   - `columns`: An array containing the column names to which you want to add filters.
   - `by`: An array containing the available filter types.
   > Supported filter types and corresponding SQL query methods:
   >- `:eq`: Equal to. Uses `where(column => value)`.
   >- `:in`: Included in. Uses `where(column => value)`.
   >- `:lt`: Less than. Uses `where("#{column} < ?", value)`.
   >- `:gt`: Greater than. Uses `where("#{column} > ?", value)`.
   >- `:le`: Less than or equal to. Uses `where("#{column} <= ?", value)`.
   >- `:ge`: Greater than or equal to. Uses `where("#{column} >= ?", value)`.
   >- `:ne`: Not equal to. Uses `where.not(column => value)`.
   >- `:not_in`: Not included in. Uses `where.not(column => value)`.
   >- `:start_with`: Starts with the specified value. Uses `where("#{column} LIKE ?", "#{value}%")`.
   >- `:like`: Fuzzy matching. Uses `where("#{column} LIKE ?", "%#{value}%")`.
   >- `:end_with`: Ends with the specified value. Uses `where("#{column} LIKE ?", "%#{value}")`.

3. Based on the defined filters, scope methods will be created for each column and filter combination.

   ```ruby
   ModelName.column1_filter1(value)
   ```

   For example, if you have a model named `User` and you want to use the "equals" (`eq`) and "greater than" (`gt`) filters for the `name` column, you can use the following code:

   ```ruby
   filterable :name, by: [:eq]
   filterable :age, by: [:gt]
   ```

   Then, you can query the `User` model as follows:

   ```ruby
   User.name_eq("John") # Returns users with the name equal to "John"
   User.age_gt(30) # Returns users with the age greater than 30
   ```

4. Use the `filter_by` method to perform combined filtering on the model.

   ```ruby
   ModelName.filter_by(filter1: value1, filter2: value2, ...)
   ```

   For example, if you want to query the `User` model based on the `name` and `age` filters, you can use the following code:

   ```ruby
   User.filter_by(name_eq: "John", age_gt: 30) # Returns users with the name equal to "John" and age greater than 30
   ```

   This will return the result set that satisfies the specified filter conditions.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kervinchang/active_filterable. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/kervinchang/active_filterable/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActiveFilterable project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kervinchang/active_filterable/blob/master/CODE_OF_CONDUCT.md).
