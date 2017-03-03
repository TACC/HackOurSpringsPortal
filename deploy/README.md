# Deploy Barton Springs Hackathon Portal 

- Create ansible hosts file with the server(s) address. Example:

    [www]
    hackoursprings.tacc.utexas.edu

- Confirm connect with Ansible

    ansible all -m ping

- Run deployment

    ansible-playbook -i /path/to/hosts deploy.yml

