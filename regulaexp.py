# -*- coding: utf-8 -*-
"""
Created on Mon Oct 19 11:07:47 2020

@author: Nana Kwesi
"""
import re

#manipulating text with regular expressions(re)
text= 'This is a good day.'
if re.search('good',text):
    print('wonderful!')
else:
    print('Alas')
    
tex='Amy works deligently. Amy gets good grades. Our student Amy is successful.'
print(re.split('Amy',tex))    
print(re.findall('Amy',tex))  
print(re.search('^Amy',tex))      #returns boleans ^ at the first of a text
print(re.search('$Amy',tex))      #returns boleans $ at the last of a text

#set operator
grades='AAAABBBCCCCCCAAAC'
print(re.findall('B',grades))
print(re.findall('[CB]',grades))
print(re.findall('[A][B-C]',grades))
print(re.findall('A{2,10}',grades))

with open('Hw4_Report.pdf','r') as file:
    wiki=file.read()
    