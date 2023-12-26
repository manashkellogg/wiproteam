system("kinit rstudiouatsvc@US.KELLOGG.COM <<< Gc1VaG!kBp0MC2PYdL50")
host <- "usawshdppd150.us.kellogg.com"
port <- "10000"
schema <- "kna_bw"
environment <- "PROD"
conn <- DBI::dbConnect(odbc::odbc(),
                       Driver = "Hive",
                       Host = "usawshdppd150.us.kellogg.com",
                       Port = port,
                       Schema = schema,
                       AuthMech = 1,
                       ThriftTransport = 1,
                       
                       HiveServerType = 2,
                       AllowSelfSignedServerCert = 1,
                       SSL = 1,
                       TrustedCerts = ifelse(environment == "PROD",
                                             "/usr/rstudio/serverpro/certs/hive_prod.pem",
                                             "/usr/rstudio2/serverpro/certs/hive.pem"), HttpPathPrefix = "/cliservice")