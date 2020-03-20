# Network/network.yml
The file  [network](/Network/network.yml) is the template which creates all the resources needed by the VPC.

# RouteTable publica

Destino  | Target
------------- | -------------
10.0.0.0/16  | local
0.0.0.0/0  | Internet Gatway

# RouteTable privada

Destino  | Target
------------- | -------------
10.0.0.0/16  | local

# Subnets

CIDR  | Nombre | Tipo
------------- | ------------- | -------------
10.0.0.0/24  | SN-Elmer-Public-1 | publica
10.0.1.0/24  | SN-Elmer-Public-2 | publica
10.0.2.0/24  | SN-Elmer-Public-3 | publica
10.0.3.0/24  | SN-Elmer-Private-1 | privada
10.0.4.0/24  | SN-Elmer-Private-2 | privada
10.0.5.0/24  | SN-Elmer-Private-3 | privada
