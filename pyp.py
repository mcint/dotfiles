
from pathlib import Path
#from pathlib import *
import pathlib as pl

# PYP_CONFIG_PATH=~/.config/shell/pyp.py
PYP_CONFIG_PATH = "~/.config/shell/pyp.py"
_file = Path(PYP_CONFIG_PATH)
_file_ = Path(PYP_CONFIG_PATH).expanduser()
__file = Path(PYP_CONFIG_PATH).read()

# _edit, _src/_env (path editor? env editor? fzf magic? bt... brotab or bluetooth)

from importlib.util import find_spec
def spec_of(tgt):
    spec = find_spec(tgt)
    return (spec, spec.submodule_search_locations)

n = int(x)
f = x.split()
j = json.load(stdin)

## shell-like shell invocations
### https://pypi.org/projects/shshsh
from shshsh import I

### https://pypi.org/projects/sh
import sh

### https://pypi.org/projects/...

## concatenative
import pipetools as pt
#from pipetools import *

## statistics
import pandas as pd
csv = pd.read_csv(stdin)

import numpy as np 
def p95(data):
    return np.percentile(data, 95)

import scipy as sp
#import scipy.stats


