from cerebralcortex import Kernel
from cerebralcortex.core.datatypes import DataStream
from util.data_helper import setup_sample_data, gen_location_datastream, gen_phone_battery_metadata
from util.sample_data import gen_stress_data
import pandas as pd
import json
from IPython.display import display
import random
from datetime import datetime, timedelta
import cufflinks as cf
from plotly.offline import iplot, init_notebook_mode
import plotly.graph_objs as go
import plotly.figure_factory as ff

import pandas as pd
import numpy as np
import ipywidgets as widgets


init_notebook_mode(connected=True)
pd.set_option('display.max_rows',5)
