# interviewtoolFullDeploy
Pipeline per il deploy di tutti i servizi dell'app interview-tool di Enrico Gatto Monticone

Le pipeline per la costruzione dei container docker, i controlli di sicurezza e il push su cloud sono nei jenkinsfile all'interno del branch deploy_riccardo

## Dashboard
Per accedere alla dashboard bisogna installare kubectl e aws cli in locale

```
aws eks --region us-east-1 update-kubeconfig --name rmazzon-eks-cluster
kubectl -n kubernetes-dashboard create token admin-user
kubectl proxy
```

Accedere a:
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
