# README

## Getting started
* Clone: `git clone git@github.com:phil-l-brockwell/Cygnetise.git`
* CD: `cd Cygnetise`
* Gems: `bundle`
* DB: `bundle exec rails db:create db:migrate`
* Test: `bundle exec rspec`
* Import: `bundle exec rails setup:import_texts\['votes.txt']` (You may or may not need the slash depending on your set up)
* Run: `bundle exec rails s`

## Design decisions

### Separate Campaign and Vote Models
I chose to write a Campaign model as when reading the specification it seemed as though votes were first organised by campaign. This grouping could have been achieved if campaign was a field on Vote but for indexing and scoping purposes it seemed a more efficient choice to have a separate model. It also avoids data redundancy.
The rake task could have just iterated over each record, totalled the votes and then built simple Campaign objects at the end, with a vote count, however this seemed like an unscalable solution. By breaking the data into two models it means additional votes/data can be added at any time.

### Validations on Vote model
I decided to build validations into the post model as their were some criteria to validate. Without these criteria met we would not want the records in the db. These validations could have been done in short methods in the rake task but it seemed like the rake task was becoming responsible for things that Models are designed for. Also it meant we could build a Vote object, add the relevant fields, and simply call the `.valid?` before saving/discarding the data.

### Fix Encoding
As is the case when importing data from txt/csv files (particularly during tech tests) stray non-utf characters often appear. I made the decision to check and remove these characters, dynamically during the task, as opposed to just removing them from the text file. Meaning that the task is reuseable and wont break when passed another input file.

## Potential Improvements

### Unique identifier for Vote
To protect against the case where a duplicate file is imported, it would be neccessary to take a unique identifier from the text and add it to the Vote model then validate it for uniqueness. I did think to use the epoch time value however it is possible (although highly unlikely) that these could be duplicated.
