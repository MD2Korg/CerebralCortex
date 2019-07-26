# Copyright (c) 2019, MD2K Center of Excellence
# - Nasir Ali <nasir.ali08@gmail.com>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
# list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

from datetime import datetime, timedelta
import random
from cerebralcortex.core.datatypes import DataStream
from cerebralcortex.core.metadata_manager.stream.metadata import Metadata, DataDescriptor, ModuleMetadata
from cerebralcortex.core.util.spark_helper import get_or_create_sc


def gen_phone_battery_metadata(stream_name)->Metadata:
    """
    Create Metadata object with some sample metadata of phone battery data
    Returns:
        Metadata: metadata of phone battery stream
    """
    stream_metadata = Metadata()
    stream_metadata.set_name(stream_name).set_description("mobile phone battery sample data stream.") \
        .add_dataDescriptor(
        DataDescriptor().set_name("level").set_attribute("description", "current battery charge")) \
        .add_module(
        ModuleMetadata().set_name("battery").set_version("1.2.4").set_attribute("attribute_key", "attribute_value").set_author(
            "Nasir Ali", "nasir.ali08@gmail.com"))
    stream_metadata.is_valid()
    return stream_metadata

def gen_phone_battery_data(CC, user_id, stream_name)->object:
    """
    Create pyspark dataframe with some sample phone battery data
    Returns:
        DataFrame: pyspark dataframe object with columns: ["timestamp", "battery_level", "version", "user"]

    """
    column_name = ["timestamp", "localtime", "user" ,"version", "battery_level"]
    sample_data = []
    timestamp = datetime(2019, 1, 9, 11, 34, 59)
    tmp = 1
    sample = 100
    sqlContext = get_or_create_sc("sqlContext")
    for row in range(1000, 1, -1):
        tmp += 1
        if tmp == 100:
            sample = sample - 1
            tmp = 1
        timestamp = timestamp + timedelta(0, 1)
        localtime = timestamp - timedelta(hours=5)
        sample_data.append((timestamp, localtime, user_id, 1, sample))
    df = sqlContext.createDataFrame(sample_data, column_name)
    metadata = gen_phone_battery_metadata(stream_name=stream_name)
    ds = DataStream(df, metadata)
    CC.save_stream(ds)
    print("Phone battery data is generated successfully.")


def gen_location_datastream(CC, user_id, stream_name)->object:
    """
    Create pyspark dataframe with some sample gps data (Memphis, TN, lat, long, alt coordinates)

    Args:
        user_id (str): id of a user
        stream_name (str): sample gps stream name

    Returns:
        DataStream: datastream object of gps location stream with its metadata

    """
    column_name = ["timestamp", "localtime", "user" ,"version" ,"latitude" ,"longitude" ,"altitude" ,"speed" ,"bearing" ,"accuracy"]
    sample_data = []
    timestamp = datetime(2019, 1, 9, 11, 34, 59)
    sqlContext = get_or_create_sc("sqlContext")
    lat = [35.1247391,35.1257391,35.1217391,35.1117391,35.1317391,35.1287391,35.5217391]
    long = [-89.9750021,-89.9710021,-89.9800021,-89.9670021,-89.9790021,-89.9710021,-89.8700021]
    alt = [83.0,84.0, 85.0, 86.0,87.0,88.0, 89.0]
    for dp in range(500):
        lat_val = random.choice(lat)
        long_val = random.choice(long)
        alt_val = random.choice(alt)
        #ts_val = 15094)+(16272882+(dp*1000000))
        speed_val = round(random.uniform(0.0,5.0),6)
        bearing_val = round(random.uniform(0.0,350),6)
        accuracy_val = round(random.uniform(10.0, 30.4),6)
        #all_dps = ",".join([ts_val, lat_val, long_val, alt_val, speed_val, bearing_val, accuracy_val])
        timestamp = timestamp + timedelta(minutes=1)
        localtime = timestamp + timedelta(hours=5)
        sample_data.append((timestamp, localtime, user_id, 1, lat_val, long_val, alt_val, speed_val, bearing_val, accuracy_val))

    df = sqlContext.createDataFrame(sample_data, column_name)

    stream_metadata = Metadata()
    stream_metadata.set_name(stream_name).set_description("GPS sample data stream.") \
        .add_dataDescriptor(
        DataDescriptor().set_name("latitude").set_type("float").set_attribute("description", "gps latitude")) \
        .add_dataDescriptor(
        DataDescriptor().set_name("longitude").set_type("float").set_attribute("description", "gps longitude")) \
        .add_dataDescriptor(
        DataDescriptor().set_name("altitude").set_type("float").set_attribute("description", "gps altitude")) \
        .add_dataDescriptor(
        DataDescriptor().set_name("speed").set_type("float").set_attribute("description", "speed info")) \
        .add_dataDescriptor(
        DataDescriptor().set_name("bearing").set_type("float").set_attribute("description", "bearing info")) \
        .add_dataDescriptor(
        DataDescriptor().set_name("accuracy").set_type("float").set_attribute("description", "accuracy of gps location")) \
        .add_module(
        ModuleMetadata().set_name("examples.util.data_helper.gen_location_data").set_attribute("attribute_key", "attribute_value").set_author(
            "Nasir Ali", "nasir.ali08@gmail.com"))
    stream_metadata.is_valid()

    ds = DataStream(data=df, metadata=stream_metadata)
    CC.save_stream(ds)

# def setup_sample_data(CC, user_id, stream_name):
#     data = gen_phone_battery_data(user_id=user_id)
#     metadata = gen_phone_battery_metadata(stream_name=stream_name)
#     ds = DataStream(data, metadata)
#     CC.save_stream(ds)

def gen_stress_data(CC, stream_name, spark_df=False):
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


    column_name = ['user','timestamp','localtime', 'version','start_time','end_time','density','location','stresser_main','stresser_sub','activity']
    sample_data = []
    timestamp = datetime(2019, 1, 9, 11, 34, 59)

    for row in range(20, 1, -1):
        if row>10:
            user_id = "a1112de1-ca36-42fc-aabe-7ec45cd552c5"
        else:
            user_id = "b1117354-ce48-4325-b2e3-78b0cc932819"
        timestamp = timestamp + timedelta(hours=random.choice([1,3,7,2,4,5]))
        localtime = timestamp - timedelta(hours=5)
        start_time = timestamp
        end_time = timestamp + timedelta(minutes=random.choice([12,6,8,16,29,45,2,3,8]))
        data_vals=random.choice(data)
        sample_data.append([user_id,timestamp,localtime,1, start_time, end_time, data_vals[0],data_vals[1],data_vals[2],data_vals[3],data_vals[4]])
    
    stream_metadata = Metadata()
    stream_metadata.set_name(stream_name).set_description("GPS sample data stream.") \
        .add_dataDescriptor(
        DataDescriptor().set_name("start_time").set_type("datetime").set_attribute("description", "start time of a stress episode.")) \
        .add_dataDescriptor(
        DataDescriptor().set_name("end_time").set_type("datetime").set_attribute("description", "end time of a stress episode.")) \
        .add_dataDescriptor(
        DataDescriptor().set_name("density").set_type("float").set_attribute("description", "density of stress")) \
        .add_dataDescriptor(
        DataDescriptor().set_name("location").set_type("string").set_attribute("description", "location where stress episode was captured.")) \
        .add_dataDescriptor(
        DataDescriptor().set_name("stresser_main").set_type("string").set_attribute("description", "stressers' main category.")) \
        .add_dataDescriptor(
        DataDescriptor().set_name("stresser_sub").set_type("string").set_attribute("description", "stressers' sub category.")) \
        .add_dataDescriptor(
        DataDescriptor().set_name("activity").set_type("string").set_attribute("description", "physical activity name")) \
        .add_module(
        ModuleMetadata().set_name("examples.util.data_helper.gen_stress_data").set_attribute("attribute_key", "attribute_value").set_author(
            "Nasir Ali", "nasir.ali08@gmail.com"))
    stream_metadata.is_valid()
    
    if spark_df:
        sqlContext = get_or_create_sc("sqlContext")
        df = sqlContext.createDataFrame(sample_data, column_name)
    else:
        df = pd.DataFrame(sample_data,columns=column_name)

    ds = DataStream(df, stream_metadata)
    #return ds
    CC.save_stream(ds)
    print("Stress data is generated successfully.")