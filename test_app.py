from click.testing import CliRunner
from app import hello

def test_hello():
    runner = CliRunner()
    result = runner.invoke(hello, ['--name', 'foo'])
    assert result.output == 'Hello foo!\n'
