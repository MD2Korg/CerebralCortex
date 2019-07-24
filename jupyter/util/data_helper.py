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


def gen_phone_battery_data(user_id)->object:
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
    return df


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
            "test_user", "test_user@test_email.com"))
    stream_metadata.is_valid()
    return stream_metadata


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
            "test_user", "test_user@test_email.com"))
    stream_metadata.is_valid()

    ds = DataStream(data=df, metadata=stream_metadata)
    CC.save_stream(ds)

def setup_sample_data(CC, user_id, stream_name):
    data = gen_phone_battery_data(user_id=user_id)
    metadata = gen_phone_battery_metadata(stream_name=stream_name)
    ds = DataStream(data, metadata)
    CC.save_stream(ds)

