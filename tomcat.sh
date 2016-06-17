chown -R cloudmunch:cloudmunch /usr/share/tomcat
chown -R cloudmunch:cloudmunch /var/log/tomcat
chown -R cloudmunch:cloudmunch /opt/jenkins
chown -R cloudmunch:cloudmunch /var/cloudbox/jenkins
chown -R cloudmunch:cloudmunch /var/cloudbox
runuser -l cloudmunch -c 'tomcat start'
tail -f /var/log/tomcat/catalina.out
