# Creates the Global [tcpout] stanza in splunk's outputs.conf
#
# Based on the outputs.conf.spec.  See at:
# (http://docs.splunk.com/Documentation/Splunk/latest/Admin/Outputsconf)

define splunk::output::tcpout (
  $defaultGroup = undef,
  $indexAndForward = undef,
  #----Common Settings----
  $sendCookedData              = undef,
  $heartbeatFrequency          = undef,
  $blockOnCloning              = undef,
  $compressed                  = undef,
  $negotiateNewProtocol        = undef,
  $channelReapInterval         = undef,
  $channelTTL                  = undef,
  $channelReapLowater          = undef,
  #----Queue Settings----
  $maxQueueSize                = undef,
  $dropEventsOnQueueFull       = undef,
  $dropClonedEventsOnQueueFull = undef,
  $maxFailuresPerInterval      = undef,
  $secsInFailureInterval       = undef,
  $backoffOnFailure            = undef,
  $maxConnectionsPerIndexer    = undef,
  $connectionTimeout           = undef,
  $readTimeout                 = undef,
  $writeTimeout                = undef,
  $dnsResolutionInterval       = undef,
  $forceTimebasedAutoLB        = undef,
  #----Automatic Load-Balancing----
  $autoLBFrequency             = undef,
  $sslPassword                 = undef,
  $sslCertPath                 = undef,
  $sslRootCAPath               = undef,
  $sslVerifyServerCert         = undef,
  $sslCommonNameToCheck        = undef,
  $sslAltNameToCheck           = undef,
  $useClientSSLCompression     = undef,
  #----Indexer Acknowledgment ----
  $useACK                      = undef
) {
  include splunk

  $_defaultGroup = any2array($defaultGroup)

  # Field Validation
  if $indexAndForward != undef {
    require Package['splunk']
  }
  if $sendCookedData != undef {
    validate_bool($sendCookedData)
  }
  if $blockOnCloning != undef {
    validate_bool($blockOnCloning)
  }
  if $compressed != undef {
    validate_bool($compressed)
  }
  if $negotiateNewProtocol != undef {
    validate_bool($negotiateNewProtocol)
  }
  if $forceTimebasedAutoLB != undef {
    validate_bool($forceTimebasedAutoLB)
  }
  if $sslVerifyServerCert != undef {
    validate_bool($sslVerifyServerCert)
  }
  # sslVerifyServerCert requires sslCommonName to Check and sslAltNameToCheck
  if $sslVerifyServerCert != undef and ($sslCommonNameToCheck == undef or $sslAltNameToCheck == undef) {
    fail( '$sslVerifyServerCert requires $sslCommonNameToCheck and $sslAltNameToCheck to be set')
  }
  if $useClientSSLCompression != undef {
    validate_bool($useClientSSLCompression)
  }
  if $useACK != undef {
    validate_bool($useACK)
  }

  realize Concat['outputs.conf']
  concat::fragment { 'tcpout':
    target  => 'outputs.conf',
    order   => 01,
    content => template( 'splunk/outputs.conf/tcpout.erb' )
  }
}
