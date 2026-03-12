#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Example to read the data
Created on Thu Mar 12 10:26:25 2026

@author: max scharf
"""

import json
import numpy as np

path = "data.json"

with open(path, "r", encoding="utf-8") as f:
    data = json.load(f)   # parses JSON into Python dictionary
srt = data["data"]
row = data["row_names"]
col = data["column_names"]

# %%
# prepare data format
srt_markedMissing = [
    [np.nan if x == "missing value" else np.double(x) for x in row] for row in srt]

# %%
# print in a neat matrix
print(("{:>10}"*(len(col)+1)).format("ID", *col))
for i, r in enumerate(srt_markedMissing):
    print(("{:>10}"+"{:10.2f}"*(len(r))).format(row[i], *r))
