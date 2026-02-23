import unittest
from src.utils import get_system_specs

class TestDeviceInfo(unittest.TestCase):
    def test_specs_return_dict(self):
        """Check if the utility returns a dictionary."""
        specs = get_system_specs()
        self.assertIsInstance(specs, dict)

    def test_essential_keys(self):
        """Check if essential keys exist in the output."""
        specs = get_system_specs()
        self.assertIn("OS", specs)
        self.assertIn("RAM", specs)

if __name__ == "__main__":
    unittest.main()