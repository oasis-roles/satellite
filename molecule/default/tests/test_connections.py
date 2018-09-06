import pytest


# Ports tcp/5647 (agent), tcp/5671 (broker) are documented for Katello/qpid
# running, but they do not report as open on the system.
# Ports tcp/8000, tcp/9090 are used during provisioning to serve kickstart
# files and transfer SCAP reports. These also do not report as open.
# It's possible that there are configuration switches that are not being set
# that affect whether these ports are actually open
@pytest.mark.parametrize("protocol, port", [
    ("tcp", 22),  # Duh
    ("tcp", 80),  # Web traffic
    ("tcp", 443),  # Secure web traffic
    ("tcp", 8140),  # Puppet master
])
def test_port(host, protocol, port):
    sock = host.socket("{0}://{1}".format(protocol, port))
    assert sock.is_listening
