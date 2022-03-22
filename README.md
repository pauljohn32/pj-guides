This is Git-LFS enabled, LFS module is needed, also the clone request requires

To allow our lfs to cooperate with web server, need to turn off SSL
verification.  This can be done globally:

    git config --global http.sslverify false

If you don't want to do that, then you need to PREPEND THIS to git commands:
 
    GIT_SSL_NO_VERIFY=true 

To pull a copy with SSH, run

GIT_SSL_NO_VERIFY=true  git clone git@gitlab.crmda.ku.edu:crmdausers/pauljohn-guides.git

A read-only copy can be cloned with https authentication

GIT_SSL_NO_VERIFY=true git clone https://pauljohn@gitlab.crmda.ku.edu/crmdausers/pauljohn-guides.git

