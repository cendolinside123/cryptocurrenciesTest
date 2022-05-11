
## all solution on this project:

1. when this application run and finish setup ListCoinViewController as root viewcontroller and initiate UI and viewmodel (CoinViewModel) setup then call method loadCoins(limit:tsym:reloadTime:) that can be access from viewmodel to do data request process. 
2. After finish data request process then the result will be store on property listCoin on viewmodel and coinResult closure called to inform viewcontroller to reload tableview and call method coinsWebSocket(toCurency:retryTime:) (access through viewmodel) to activate web socket to get real time data, all web socket will send from viewmodel to viewcontroller through webSocketResponse closure and do update property listCoin data

in this project I use:
1. Alamofire --> for do API request
2. SwiftyJSON --> for simplfy encapsulate json from API request to struct model
3. Starscream --> for web socket


### inside loadCoins(limit:tsym:reloadTime:)

1. do API request process using fetchCoin(limit:tsym:completion:) that can be access through useCase property (CointUseCase)
2. if API request return error:
   * check number of reloadTime, if bigger than 0 than re-call loadCoins(limit:tsym:reloadTime:) again with reloadTime-1, but if reloadTime is 0 then send error message to viewcontroller through fetchError closure
3. if API request success and return data list of coin (NOTE: the process bellow is created to handle the issue data price and openday value is difference between API request response and websocket response cause displayed price and price gain not accurate after user refresh table):
   * if property listCoin is empty:
     * save data list of coin to property listCoin and give response to viewcontroller through coinResult closure and the process is end here
   * if number of data on listCoin is difference with data from API request response:
     * if number of data in listCoin < number of data from API request response:
       * do a comparison between them to find some data coins from API request response that does not exist in property listCoin
       * save comparison result data to private property tempCoin (tempCoin is used on coinsWebSocket(toCurency:retryTime:))
       * append comparison result data to property listCoin
       * give response to viewcontroller through coinResult closure and the process is end here
     * if number of data in listCoin > number of data from API request response:
       * do a comparison between them to find some data coins from property listCoin  that does not exist in API request response
       * remove data of coin on listCoin property base on comparison result
       * give response to viewcontroller through coinResult closure and the process is end here

    * if number of data on listCoin is same with data from API request response:
       * do a comparison between them to find some data coins from API request response that does not exist in property listCoin
       * if comparison result return some data:
         * save comparison result data to private property tempCoin (tempCoin is used on coinsWebSocket(toCurency:retryTime:))
         * append comparison result data to property listCoin (do merged betwee two list data of coin)
         * give response to viewcontroller through coinResult closure and the process is end here
       * if comparison result return is empty:
         * give response to viewcontroller through coinResult closure and the process is end here


### inside coinsWebSocket(toCurency:retryTime:)

1. check if number of data inside private property tempCoin is not 0:
   * if fulfill then call addNewEntry(coins:toCurency:) that can be access through webSocket property (this process is use for send new coin to connected web socket, so web socket ken get return new data about new coin instead of toggling web socket connection for getting new web socket information)
   * clear all data inside tempCoin
   * process end here
2. if tempCoin.count == 0:
   * call method connect(coins:toCurency:completion:) that can be access through webSocket private property
     * if response error:
       * check number of reloadTime, if bigger than 0 than re-call oinsWebSocket(toCurency:retryTime:) again with reloadTime-1, but if reloadTime is 0 then send error message to webSocketError through fetchError closure
   


## what else I could have done with more time (with solution).


1. Make Unit Testing more spesific, solution:
  * make list of issue that cause a bug