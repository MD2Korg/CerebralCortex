from cerebralcortex import Kernel
from util.data_helper import gen_phone_battery_data, gen_location_datastream, gen_phone_battery_metadata,gen_stress_data
import json
from IPython.display import display
import cufflinks as cf
from plotly.offline import iplot, init_notebook_mode
import plotly.graph_objs as go
import plotly.figure_factory as ff
import numpy as np
import pandas as pd
from datetime import datetime, timedelta
import random
from cerebralcortex.core.datatypes import DataStream
from cerebralcortex.core.metadata_manager.stream.metadata import Metadata, DataDescriptor, ModuleMetadata
from cerebralcortex.core.util.spark_helper import get_or_create_sc
import ipywidgets as widgets


init_notebook_mode(connected=True)
pd.set_option('display.max_rows',5)
