import pandas as pd
import random
from datetime import datetime, timedelta
from datetime import datetime, timedelta
import random
from cerebralcortex.core.datatypes import DataStream
from cerebralcortex.core.metadata_manager.stream.metadata import Metadata, DataDescriptor, ModuleMetadata
from cerebralcortex.core.util.spark_helper import get_or_create_sc

def gen_stress_data(spark_df=False):
    data = [[0.7, "road", "Driving", "Was Tailgated", "IN_VEHICLE"],
            [0.3, "work", "Job", "Bored / Not enough to do", "STILL"],
            [0.5, "home", "Health", "Physical inability", "STILL"],
            [0.6, "road", "Driving", "Saw a police car", "IN_VEHICLE"],
            [0.38, "work", "Job", "Technology barriers", "STILL"],
            [0.2, "home", "Finance", "Missed payment", "UNKNOWN"],
            [0.9, "work", "Finance", "Unexpected losses", "WALKING"],
            [0.54, "road", "Driving", "Difficulty in navigating", "IN_VEHICLE"],
            [0.79, "work", "Job", "Unpleasant conversation", "ON_FOOT"],
            [0.28, "road", "Health", "My eating habits", "IN_VEHICLE"],
            [0.47, "road", "Driving", "Indecision at a traffic intersection", "IN_VEHICLE"],
            [0.67, "work", "Job", "Late arrival", "WALKING"],
            ]


    column_name = ['user_id','timestamp','start_time','end_time','density','location','stresser_main','stresser_sub','activity']
    sample_data = []
    timestamp = datetime(2019, 1, 9, 11, 34, 59)

    for row in range(20, 1, -1):
        if row>10:
            user_id = "a1112de1-ca36-42fc-aabe-7ec45cd552c5"
        else:
            user_id = "b1117354-ce48-4325-b2e3-78b0cc932819"
        timestamp = timestamp + timedelta(hours=random.choice([1,3,7,2,4,5]))
        start_time = timestamp
        end_time = timestamp + timedelta(minutes=random.choice([12,6,8,16,29,45,2,3,8]))
        data_vals=random.choice(data)
        sample_data.append([user_id,timestamp, start_time, end_time, data_vals[0],data_vals[1],data_vals[2],data_vals[3],data_vals[4]])

    if spark_df:
        sqlContext = get_or_create_sc("sqlContext")
        df = sqlContext.createDataFrame(sample_data, column_name)
    else:
        df = pd.DataFrame(sample_data,columns=column_name)
    return df
    
