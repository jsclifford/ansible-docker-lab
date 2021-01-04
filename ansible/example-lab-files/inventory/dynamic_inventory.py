#!/usr/bin/env python3

''' 
Sample custom dynamic inventory script for ansible, in Python.
'''

import os
import sys
import argparse

try:
    import json
except ImportError:
    import simplejson as json

class ExampleInventory(object):

    def __init__(self):
        self.inventory = {}
        self.read_cli_args()

        # Called with `--list`.
        if self.args.list:
            self.inventory = self.example_inventory()
        # Called with `--host [hostname]`.
        elif self.args.host:
            # Not implemented, since we return _meta info `--list`.
            self.inventory = self.empty_inventory()
        else:
            self.inventory = self.empty_inventory()

        print(json.dumps(self.inventory));
    
    def example_inventory(self):
        return {
            "group": {
                "hosts": [
                    "web01",
                    "web02",
                    "db01",
                    "db02"
                ],
                "vars": {
                    "example_variable": "value"
                }
            },
            "_meta": {
                "web01": {
                    "host_specific_var": "web01"
                },
                "web02": {
                    "host_specific_var": "web02"
                },
                "db01": {
                    "host_specific_var": "db01"
                },
                "db02": {
                    "host_specific_var": "db02"
                }
            }
        }
    
    # Empty inventory for testing.
    def empty_inventory(self):
        return {'meta': {'hostvars':{}}}

    # Read the command line args passed to the script.
    def read_cli_args(self):
        parser = argparse.ArgumentParser()
        parser.add_argument('--list', action = 'store_true')
        parser.add_argument('--host', action = 'store')
        self.args = parser.parse_args()

# Get the inventory.
ExampleInventory()