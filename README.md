# Bank OCR Kata

Instructions can be found [here](https://github.com/testdouble/contributing-tests/wiki/Bank-OCR-kata).

### User Story 1

The first user story covers reading documents with bank account numbers into a
list of parsed `account numbers`. These documents can be found as `.txt` files
in `spec/fixtures`.

### User Story 2

The second user story covers validating each `account_number` using a checksum
calculation. The result returns a hash object with `valid`, `invalid`, and
`illegible` keys; each containing a list of validated account numbers.

### User Story 3

The third user story covers printing the results from user story 2 into a file.
Each account number is printed onto the file with it's status; valid, invalid,
or illegible.

## Testing
Specs can be found in `spec/lib`. If you'd like to run these tests locally,
ensure you have RSpec installed, and run the following command:

```
rspec spec/lib/ocr_spec.rb
```

## Source
The core functionality can be found in the `OCR` class. This class handles the
logic for parsing documents, validating account numbers, and printing the results
into a new file in the `results/` folder.

There's also a `Glossary` class that provides mappings for digits found in
documents as pipes and underscores. These mappings are used by `OCR` when parsing
documents for account numbers.

These classes can be found in `lib/`.

## Executables
In `spec/fixtures/` there is a file named `use_case_03.txt` that contains
valid, invalid, and illegible, account numbers. If you'd like to see these 3
user stories in action, run the following command line script from your console
and inspect the file created in `results/`:

```
ruby bin/ocr.rb
```
