---
id: 2085
title: 'Exchange UM doesn&#8217;t answer calls after SP1 upgrade'
date: 2010-12-31T13:48:31+00:00
author: Johan Veldhuis
layout: post
guid: http://johanveldhuis.nl/?p=2085
permalink: /exchange-um-doesnt-answer-calls-after-upgrade-to-sp1/
categories:
  - Exchange
---
During an upgrade to Exchange 2010 SP1 I had a nasty problem. After the upgrade of the Unified Messaging server the server didn&#8217;t accept any calls.  

In this case the Unified Messaging server was connected to a Nortel CS1000 which used the Subscriber Access and Auto-Attendant of Exchange.  

But how can you find out what is going wrong? First a look at the event log may be usefull but in this case nothing strange could be found there. Because the default log level is set to a low level it was necessary to raise the log level to a higher level. This can be done via two methods:  

  * Exchange Management Console
  * Exchange Management Shell

_**Exchange Management Console**_  

  * open the Exchange Management Console
  * select the node _server management_
  * select the _Unified Messaging_ server
  * select the option _Manage Diagnostics Logging_ in the right menu
  * search for _MsExchange Unified Messaging_ in the list
  * raise the logging level for the following items: _UMCalldata, UMCore and UMService_

**_Exchange Management Shell_  **

  * open the _Exchange Management Shell_
  * execute the following Powershell cmdlets:

```PowerShell
 Set-EventlogLevel 'Servername\MSExchange Unified Messaging\UMCalldata' -level Expert 

Set-EventlogLevel 'Servername\MSExchange Unified Messaging\UMCore' -level Expert 

Set-EventlogLevel 'Servername\MSExchange Unified Messaging\UMService' -level Expert  
````
Don&#8217;t forget to reset the logging level to the original level when you are ready with troubleshooting.  

When the logging level is raised it&#8217;s time to reproduce the issue. This can be done by, for example, call the Subscriber Access.  

In this case this doesn&#8217;t help you much either so there was one option left: use a sniffer. Personally my favorite is Wireshark which can be downloaded for free from this <a href="http://www.wireshark.org/" target="_blank">site</a>.   

Once installed it&#8217;s time to reproduce the issue again, don&#8217;t forget to enable the capture before doing this.  

[<img title="Wireshark UM trace" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2010/12/um-300x18.jpg?resize=300%2C18" alt="" width="300" height="18" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2010/12/um.jpg)  

When you have reproduced the issue you will see a lot of messages which are captured. Among them messages which are from the protocol type SIP. Select one of these rules and select the option _Analyze _followed by _Follow TCP Stream._ This will give an overview of all SIP messages.  

Normally you will see the messages below:   

[<img title="SIP workflow" src="https://i1.wp.com/johanveldhuis.nl/wp-content/uploads/2010/12/sip-300x278.jpg?resize=300%2C278" alt="" width="300" height="278" data-recalc-dims="1" />](https://i0.wp.com/johanveldhuis.nl/wp-content/uploads/2010/12/sip.jpg)  

When the problem occurs you will find only two messages Invite and Moved Temporarily:  

<div>
  <em>SIP/2.0 302 Moved Temporarily</p> 
  
  <p>
    </em><em>FROM: &#8220;Johan Veldhuis&#8221;<sip:110@pabx.local;user=phone>;tag=4ed6938-a161f0a-13c4-40030-6e2965-28e24116-6e2965 </p> 
    
    <p>
      </em><em>TO: <sip:101@pabx.local;user=phone>;epid=EEBEB645D0;tag=4c63a61135 </p> 
      
      <p>
        </em><em>CSEQ: 1 INVITE </p> 
        
        <p>
          </em><em>CALL-ID: 5219808-a161f0a-13c4-40030-6e2965-72d8d4f0-6e2965 </em><em>VIA: SIP/2.0/TCP 192.168.1.60:5060;branch=z9hG4bKc2922de4f77bdbe59f2613f3.1,SIP/2.0/TCP 192.168.1.10:<strong>5060</strong>;received=192.168.1.10;branch=z9hG4bK-6e2965-ae51b48a-6f4d0e7 </p> 
          
          <p>
            </em><em>CONTACT: <sip:101@pabx.local:<strong>5065</strong>;user=phone;transport=Tcp;maddr=pabx.local> </p> 
            
            <p>
              </em><em>CONTENT-LENGTH: 0 </p> 
              
              <p>
                </em><em>SERVER: RTCC/3.5.0.0  </em></div> 
                
                <p>
                  When having a look at the trace above you will see that besides port 5060 also port 5065 is used. Exchange UM will try to redirect the traffic to port 5065. As the Nortel will continue to send messages to port 5060 the call won&#8217;t succeed. To solve this issue you will need to make a modification to the trunk so it will send messages via poty 5065 instead of 5060. 
                </p>
                
                <p>
                  Once this has been changed the Nortel will be able to setup a connection to the Exchange UM server. But is this a real solution? Not really but this will require some additional explanation.  
                </p>
                
                <p>
                  So why does Exchange wants to redirect the traffic to port 5065 and doesn&#8217;t use port 5060 which is used for SIP by default. Port 5060 is also used by Exchange for SIP but besides this another process is running called the UM Worker process which does the real work. Exchange will use the following ports for this:  
                </p>
                
                <ul>
                  <li>
                    5065 and 5067 for SIP
                  </li>
                  <li>
                    5066 and 5068 for Secure SIP
                  </li>
                </ul>
                
                <p>
                  The Exchange UM Worker process will be recycled once a week, this may has as a result that the Nortel can&#8217;t setup a connection after one week. This because the UM Worker process is recycled and now is using 5067.  
                </p>
                
                <p>
                  But is there a solution for this issue? Well at this moment there isn&#8217;t one but I think somebody in the background is working hard on a solution for this. So for now we have the following options:  
                </p>
                
                <ul>
                  <li>
                    don&#8217;t upgrade Exchange 2010 SP1
                  </li>
                  <li>
                    place a gateway between the Exchange 2010 UM server and the Nortel environment
                  </li>
                  <li>
                    reboot the Exchange 2010 UM server once a week
                  </li>
                </ul>
                
                <p>
                  Because all options are not really a good solution you may need to choose the best of these three, from my point of view the last one. 
                </p>
                
                <p>
                  If you would like to have more info about the Exchange 2010 UM process have a look at the following <a href="http://technet.microsoft.com/en-us/library/bb125141.aspx" target="_blank">site</a>.
                </p>