### what else I could have done with more time (with solution).
1. change Coin model can flexible to save non-crypto curency type, because I only set it read USD type, solution: 
  1. change name of struct model UsdCurencybecome more global
  2. add more parameter about non-crypto curency type on init Coin and UsdCurencybecome so I can set value of selected currency to json key name by that parameter
2. validate the number of price or price change is in correect format, solution:
  1. make validation value more spesific base on received value from API request
3. Make Unit Testing more spesific, solution:
  1. make list of issue that cause a bug
4. Fix label constrain on splashscreen
  1. reduce label size or make text font resize base label width