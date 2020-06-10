import json
import subprocess
import sys
from subprocess import PIPE

DEPLOYMENT=sys.argv[1]

def delete_vm(vm_cid):
    print("deleting {}".format(vm_cid))
    completed = subprocess.run(
        ['bosh -d \'{0}\' -n delete-vm {1}'.format(DEPLOYMENT, vm_cid)],
        stdout=PIPE,
        stderr=PIPE,
        shell=True
    )
    print(completed.stdout)
    

completed = subprocess.run(
    ['bosh -d \'{0}\' vms --json'.format(DEPLOYMENT)],
    stdout=PIPE,
    stderr=PIPE,
    shell=True
)

raw = completed.stdout

json_string = raw.decode('utf-8')

vm_json = json.loads(json_string)

vms = vm_json['Tables'][0]['Rows']

print(len(vms))
dead_vms = []
for vm in vms:
    if vm['process_state'] == 'unresponsive agent':
        if vm['instance'].startswith('worker'):
            dead_vms.append(vm['vm_cid'])

print(dead_vms)

for dead_vm in dead_vms:
    delete_vm(dead_vm)



