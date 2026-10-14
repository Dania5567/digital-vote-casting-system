# Testing and demonstration

## Physical demonstration

The breadboard photograph documents the assembled hardware using multiple ICs and five illuminated seven-segment displays. The Proteus capture documents the corresponding digital-logic simulation layout.

## Functional verification procedure

1. Initialize/reset registers and verify that counters start at zero.
2. Present voter ID `000` and select candidate C1.
3. Apply one qualified vote pulse; verify that C1 increments once.
4. Repeat the vote using the same ID; verify that the reference model does not count it twice.
5. Repeat with other voter IDs and candidate selections.
6. Test the invalid voter codes `101`–`111` and invalid candidate code `11`.
7. Check vote totals and comparator output for a clear leader and a tie.
8. Confirm numerical display patterns for decimal digits `0`–`9`.

## Example recorded test sequence (reference model)

| Voter | Candidate | After-event totals C1/C2/C3 |
|---|---|---|
| 000 | C1 | 1/0/0 |
| 001 | C2 | 1/1/0 |
| 010 | C1 | 2/1/0 |
| 000 | C3 | 2/1/0 (duplicate rejected) |
| 011 | C3 | 2/1/1 |
| 100 | C2 | 2/2/1 (tie) |

The automated tests validate this newly supplied HDL behavior. They are independent of the screenshot's displayed numerical values.
