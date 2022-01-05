mkdir -p /home/$HOME/create-contexts

sudo cp $HOME/.kube/config $HOME/.kube/kube-config.bkp

# add the contex to "$HOME/.kube/config"
sudo sed -i '/^current-context:/i - context:\n    cluster: kubernetes\n    user: kubernetes-admin\n  name: k8s-c1-H' $HOME/.kube/config
sudo sed -i '/^current-context:/i - context:\n    cluster: kubernetes\n    user: kubernetes-admin\n  name: k8s-c2-AC' $HOME/.kube/config
sudo sed -i '/^current-context:/i - context:\n    cluster: kubernetes\n    user: kubernetes-admin\n  name: k8s-c3-CCC' $HOME/.kube/config

k config get-contexts
