#! /usr/bin/env python

# Definition of dataframes that will be used in other partes of the workflow
#
# import pandas as pd

##### read in samples table CSV file and store in dataframe
#
# use rename method on the dataframe to change the column names
# and control our vectors names better
cumples_table = pd.read_csv(
    config['cumples_data']['filename']
    ).rename(columns={
        config['cumples_data']['nombre']: 'nombre',
        config['cumples_data']['fecha']: 'fecha',
        config['cumples_data']['color_pastel']: 'color_pastel',
        config['cumples_data']['color_frosting']: 'color_frosting'
    })

##### set nombre as the index of cumples_table and store the resulting dataframe in people. 
#
# Now people is a new dataframe with the same rows as cumples_table but with nombre column as the index
# this means we can use the .loc method to access rows and columns in the dataframe by index
people = cumples_table.set_index('nombre')

