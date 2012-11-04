SOFTPLC - Ruby client
=====================

This gem uses webservice on Domat's MiniPLC to retrieve variables values from SoftPLC.

Usage:

    Softplc.configuration.host = '192.168.1.160'

    uuids = [
      "46261352-25c4-4287-975a-1f01aceb6cca",
      "d864af63-fb44-459a-86d6-8f9024a0ed17",
      "236ce0d1-c8d7-45c0-a296-4ecbc2f455ec"
    ]

    @fetcher = Softplc::Fetcher.new(uuids).values
    => ["34.649998", "36.388296", "32.510555"]

