# Logger実装サンプル



```kotlin

enum class LoggerLevel {
  VERBOSE, DEBUG, INFO, WARN, ERROR, ASSET
}

abstract class Logger(level: LogLevel, tag: String) {
  var logLevel: LogLevel = level
  var logTag: String = tag
  
  abstract fun verbose(format: String)
  abstract fun debug(format: String)
  abstract fun info(format: String)
  abstract fun warn(format: String)
  abstract fun error(format: String)
  abstract fun asset(format: String)
  
}

class DefaultLogger(level: LogLevel, tag: String) : Logger(level, tag) {
  
  override fun verbose(format: String) {
    Log.d(logTag, format)
  }
  
  ...
  
}

class ApiClient {
  
  var logger: Logger = DefaultLogger("ApiClient", LogLevel.DEBUG)
  
  fun callA() {
    
    logger.debug("callA start")
    logger.verbose("params : brbr")    
    
    .....
    
    logger.debug("callB end")    
    
  }
  
}

class LogicForDebug {
  
  val apiClient = ApiClient()
  
  init {
    apiClient.logger = SaveToFileLogger("ApiClient", LogLevel.VERBOSE)    
  }
  
  fun something() {
    
    apiClient.callA()
    
  }
  
}


class SaveToFileLogger(level: LogLevel, tag: String) : Logger(level, tag) {
  
  override fun verbose(format: String) {
    this.appendToFile(format)
  }  
}

```