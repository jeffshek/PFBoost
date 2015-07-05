### TEMPORARY Function to load data only 
### Peyton Greenside
### 6/18/15

import sys
import os
import random

import numpy as np 
from scipy.sparse import *

import argparse
import pandas as pd
import multiprocessing
import ctypes

from functools import partial
import time
from collections import namedtuple
import pdb
import pickle

from boosting_2D import config
from boosting_2D import util
from boosting_2D import plot
from boosting_2D import margin_score
from boosting_2D.data_class import *
from boosting_2D.find_rule import *
from boosting_2D import stabilize
from boosting_2D import prior

# Load config
TuningParams = namedtuple('TuningParams', [
    'num_iter',
    'use_stumps', 'use_stable', 'use_corrected_loss', 'use_prior',
    'eta_1', 'eta_2', 'bundle_max', 'epsilon'
])
config.OUTPUT_PATH = '/srv/persistent/pgreens/projects/boosting/results/'
config.OUTPUT_PREFIX = 'hematopoeisis_23K_stable_bindingTFsonly'
config.TUNING_PARAMS = TuningParams(
    100, 
    False, True, False,
    True,
    0.05, 0.01, 20, 1./holdout.n_train)
config.NCPU = 4

# Load y
y = TargetMatrix('/srv/persistent/pgreens/projects/boosting/data/hematopoeisis_data/accessibilityMatrix_full_subset_CD34.txt', 
                 '/srv/persistent/pgreens/projects/boosting/data/hematopoeisis_data/peak_headers_full_subset_CD34.txt', 
                 '/srv/persistent/pgreens/projects/boosting/data/hematopoeisis_data/cell_types_pairwise.txt',
                 'triplet',
                 'sparse')
# Load x1
x1 = Motifs('/srv/persistent/pgreens/projects/boosting/data/hematopoeisis_data/annotationMatrix_full_subset_CD34.txt', 
            '/srv/persistent/pgreens/projects/boosting/data/hematopoeisis_data/peak_headers_full_subset_CD34.txt', 
            '/srv/persistent/pgreens/projects/boosting/data/hematopoeisis_data/annotationMatrix_headers_full.txt',
            'triplet',
            'sparse')

# Load x2
x2 = Regulators('/srv/persistent/pgreens/projects/boosting/data/hematopoeisis_data/regulatorExpression_bindingTFsonly.txt', 
                '/srv/persistent/pgreens/projects/boosting/data/hematopoeisis_data/regulator_names_bindingTFsonly.txt', 
                '/srv/persistent/pgreens/projects/boosting/data/hematopoeisis_data/cell_types_pairwise.txt',
                'triplet',
                'sparse')

# Load holdout
holdout = Holdout(y, 'sparse')

# Prior
params=prior.PriorParams(
    50, 0.998,
    'matrix', 
     '/srv/persistent/pgreens/projects/boosting/data/hematopoeisis_data/prior_data/motifTFpriors.txt',\
      '/srv/persistent/pgreens/projects/boosting/data/hematopoeisis_data/prior_data/motifTFpriors.rows.txt', \
     '/srv/persistent/pgreens/projects/boosting/data/hematopoeisis_data/prior_data/motifTFpriors.columns_gene_only.txt', \
    None, None, None)
prior_mr, prior_rr = prior.parse_prior(params, x1, x2)

# Load tree
tree = pickle.load(open('/srv/persistent/pgreens/projects/boosting/results/saved_trees/hematopoeisis_23K_stable_bindingTFsonly_saved_tree_state_adt_stable_1000iter', 'rb'))

