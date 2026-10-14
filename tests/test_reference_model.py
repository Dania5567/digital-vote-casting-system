"""Independent behavioral checks for the supporting RTL design."""
import unittest

class VoteSystem:
    def __init__(self):
        self.counts = [0, 0, 0]
        self.used = set()

    def cast(self, voter_id, candidate):
        if voter_id not in range(5) or candidate not in range(3) or voter_id in self.used:
            return False
        self.used.add(voter_id)
        self.counts[candidate] += 1
        return True

    def leader(self):
        top = max(self.counts)
        leaders = [i for i, v in enumerate(self.counts) if v == top]
        return leaders[0] if len(leaders) == 1 else None

class VoteTests(unittest.TestCase):
    def test_votes(self):
        s = VoteSystem()
        for voter, cand in [(0,0),(1,1),(2,0),(3,2),(4,1)]:
            self.assertTrue(s.cast(voter,cand))
        self.assertEqual(s.counts,[2,2,1])
        self.assertIsNone(s.leader())

    def test_duplicate(self):
        s = VoteSystem()
        self.assertTrue(s.cast(0,0))
        self.assertFalse(s.cast(0,1))
        self.assertEqual(s.counts,[1,0,0])

    def test_invalid(self):
        s = VoteSystem()
        for voter, candidate in [(5,0),(7,1),(0,3),(-1,0)]:
            self.assertFalse(s.cast(voter,candidate))
        self.assertEqual(s.counts,[0,0,0])

    def test_unique_leader(self):
        s = VoteSystem()
        s.cast(1,2)
        self.assertEqual(s.leader(),2)

    def test_all_tied_on_reset(self):
        self.assertIsNone(VoteSystem().leader())

if __name__ == '__main__': unittest.main()
