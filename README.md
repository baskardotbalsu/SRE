# CSI-ZG628T-Dissertation
BIT Pilani M.Tech 2nd year 2nd Sem Dissertation work

# DISSERTATION DEMONSTRATION VIDEO
***Click the video link shown below***<br><br>
[![DISSERTATION VIDEO](https://i9.ytimg.com/vi/LHNCHVT70Zk/mq1.jpg?sqp=CLT2mYQG&rs=AOn4CLDrQJ6y2QzfrJOTKEy4C2m8cfU_Ag)](https://youtu.be/LHNCHVT70Zk "DEMO-CSI-ZG628T-Dissertation") <br>

Refer to the dissertation documentation
https://github.com/baskardotbalsu/SRE/blob/2019HT66015_CSI-ZG628T-Dissertation/doc/FinalReport/soft-submit/FinalReport.pdf
for complete details of the project. <br>

# Automation Solution is now tested with centos7.0
Test results available [[here]](https://github.com/baskardotbalsu/SRE/blob/2019HT66015_CSI-ZG628T-Dissertation/results/invoking_main_script_centos7.0.txt "Test results centos7.0") <br>

# ABSTRACT

Reliability of a website is a quality that is measured based on user experience. It appears to be simple phenomenon from the outside, but it takes constant effort in steering the moving parts of the systems and software behind the scene. Automation, monitoring and alerting of the system functions and effective communication among the systems and support personnel are few of the foundational requirements that attempts to solve the problem of site reliability. 

The choice of tools used to meet the above requirements becomes crucial to deploy such an eco-system. In this dissertation work, there is an attempt to study Ansible, a Python based configuration management tool, as the Automation tool and how it helps to eliminate the toil due to tasks that are manual, repetitive, automatable, tactical, devoid of enduring value, and that scales linearly as a service grows. The work also involves studying the interfacing capabilities of ansible with tools that helps in monitoring the system metrics and visualize the data captured for analysis. The monitoring tool under consideration is Prometheus while the visualization tool considered is Grafana. 

The use-case for the project involves automating the deployment of docker container, running a TCP Echo Server, hosted on top of a Linux Virtual Machine. The operations of Linux VM, Docker container and TCP Echo Server are all automated using Ansible as the automation tool. A TCP Echo client runs anywhere within or outside Linux VM, can be used to send TCP echo messages to the TCP Server, to test the application functionality.

This effort demonstrates the value of automating the repeatable task of deploying the docker containers with a hosted server, in a large scale environment, such as a cloud data center. The use-case also demonstrates the value of using monitoring and visualizing tools such as Prometheus and Grafana, respectively,  that can interface with Ansible in the deployed environment. The scope of system parameters captured for monitoring and analysis with the tools is restricted to the TCP statistics such as the number of connections, state of the connections, etc.  There will be a detailed analysis on how Ansible automation combined with monitoring and analytics of the system, can address the problem of site reliability. 

The extensibility of the project is such that, TCP Echo Server can be replaced with any other server like web servers, application servers, etc during study. Having the server as TCP Echo Server can be of much use for students with academic interest on the study. It can be shown that it is simple to develop, modify, build the code base for the TCP Echo Server and monitor the system characteristics that are fundamental to study any server that run over a TCP protocol. 

On the other hand, the time needed to build, develop or extend web server or application servers, with voluminous code base is time consuming. In this case, complex system characteristics involving application layer protocols like HTTP, TLS, SOAP, etc are generally considered for study. This study with TCP Echo Server is analogous to study of the implementation of Data Encryption Standard (DES) in field of Cryptography, the fundamental block cipher algorithm, before studying the more complex algorithms like Advanced Encryption Standard. With this approach, the dissertation gives a way for a wide range of options for future study by keeping this project as the reference study on Site Reliability of web sites.  

