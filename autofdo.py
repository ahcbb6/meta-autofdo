# This is a sample test use with meta-autofdo
# to profile and optimize an application

# Usage:

# On local.conf add (without comments):
# INHERIT += "testimage"
# TEST_TARGET = "simpleremote"
# TEST_TARGET_IP = <TARGET IP ADDRESS>
# TEST_SERVER_IP = <DEV SYSTEM / HOST IP ADDRESS>
# TEST_SUITES =  " autofdo"

# And add if were profiling or optimizing accordingly:
# AUTOFDO_FLAG = "0" # Profiling
# AUTOFDO_FLAG = "1" # Optimizing/Deploying

# alejandro.hernandez@linux.intel.com


import os
import unittest
import subprocess
from oeqa.oetest import oeRuntimeTest
from oeqa.utils.decorators import *


class AutoFdoTest(oeRuntimeTest):

    @classmethod
    def setUpClass(self):
        self.msg = ""

    # Copy gcov file from TARGET to HOST
    def transfer_gcov(self):
        autofdo_bin = oeRuntimeTest.tc.d.getVar('AUTOFDO_BIN', True)
        dl_dir = oeRuntimeTest.tc.d.getVar('DL_DIR', True)
        if not os.path.exists(dl_dir):
            bb.warn('Downloads directory does not exist?')
        self.target.copy_from('/home/root/%s.gcov' % autofdo_bin, target_logs)

    # Run the application
    def run_profile(self):
        autofdo_bin = oeRuntimeTest.tc.d.getVar('AUTOFDO_BIN', True)
        bb.warn(autofdo_bin)
        # Debug
        #(status, dmesg) = self.target.run('pwd > /home/root/pwd')
        (status, dmesg) = self.target.run('autofdo_%s > 1' % autofdo_bin)
        #(status, dmesg) = self.target.run('echo abc > /home/root/abc')

    # We need ssh to run the application and download the profiled data
    @testcase(1059)
    @skipUnlessPassed('test_ssh')
    def test_autofdo(self):
        self.run_profile()
        self.transfer_gcov()
        self.msg += "Done:\n"
