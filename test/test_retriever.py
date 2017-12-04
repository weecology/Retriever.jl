# -*- coding: latin-1  -*-
"""Tests for the Data Retriever"""
from future import standard_library

standard_library.install_aliases()
import os
import sys
import shutil
from imp import reload
from retriever.lib.defaults import ENCODING

encoding = ENCODING.lower()

reload(sys)
if hasattr(sys, 'setdefaultencoding'):
    sys.setdefaultencoding(encoding)
from retriever.lib.engine import Engine
from retriever.lib.table import Table
from retriever.lib.templates import BasicTextTemplate
from retriever.lib.cleanup import correct_invalid_value
from retriever.lib.tools import getmd5
from retriever.lib.tools import xml2csv
from retriever.lib.tools import json2csv
from retriever.lib.tools import sort_file
from retriever.lib.tools import sort_csv
from retriever.lib.tools import create_file
from retriever.lib.tools import file_2list
from retriever.lib.datapackage import clean_input, is_empty
from retriever.lib.compile import add_dialect, add_schema

# Create simple engine fixture
test_engine = Engine()
test_engine.table = Table("test")
test_engine.script = BasicTextTemplate(tables={'test': test_engine.table},
                                       name='test')
test_engine.opts = {'database_name': '{db}_abc'}
HOMEDIR = os.path.expanduser('~')
file_location = os.path.dirname(os.path.realpath(__file__))
retriever_root_dir = os.path.abspath(os.path.join(file_location, os.pardir))


def setup_module():
    """"Make sure you are in the main local retriever directory."""
    os.chdir(retriever_root_dir)


def teardown_module():
    """Make sure you are in the main local retriever directory after these tests."""
    os.chdir(retriever_root_dir)


def test_auto_get_columns():
    """Basic test of getting column labels from header."""
    test_engine.table.delimiter = ","
    columns, column_values = test_engine.table.auto_get_columns(
        ['a', 'b', 'c', 'd'])
    assert columns == [['a', None], ['b', None], ['c', None], ['d', None]]


def test_auto_get_datatypes():
    """Test the length detected by auto_get_datatype.

    The function adds 100 to the auto detected length of column
    """
    test_engine.auto_get_datatypes(None,
                                   [["ö", 'bb', 'Löve']],
                                   [['a', None], ['b', None], ['c', None]],
                                   {'a': [], 'c': [], 'b': []})
    length = test_engine.table.columns
    assert [length[0][1][1], length[1][1][1], length[2][1][1]] == \
           [101, 102, 104]


def test_auto_get_columns_extra_whitespace():
    """Test getting column labels from header with extra whitespace."""
    test_engine.table.delimiter = ","
    columns, column_values = test_engine.table.auto_get_columns(
        ['a', 'b', 'c', 'd  '])
    assert columns == [['a', None], ['b', None], ['c', None], ['d', None]]


def test_auto_get_columns_cleanup():
    """Test of automatically cleaning up column labels from header."""
    test_engine.table.delimiter = ","
    columns, column_values = test_engine.table.auto_get_columns([
        'a)', 'a\nd', 'b.b', 'c/c', 'd___d', 'group'])

    assert columns == [['a', None],
                       ['ad', None],
                       ['b_b', None],
                       ['c_c', None],
                       ['d_d', None],
                       ['grp', None]]


def test_auto_get_delimiter_comma():
    """Test if commas are properly detected as delimiter."""
    test_engine.auto_get_delimiter("a,b,c;,d")
    assert test_engine.table.delimiter == ","


def test_auto_get_delimiter_tab():
    """Test if commas are properly detected as delimiter."""
    test_engine.auto_get_delimiter("a\tb\tc\td,")
    assert test_engine.table.delimiter == "\t"


def test_auto_get_delimiter_semicolon():
    """Test if semicolons are properly detected as delimiter."""
    test_engine.auto_get_delimiter("a;b;c;,d")
    assert test_engine.table.delimiter == ";"


def test_correct_invalid_value_string():
    assert \
        correct_invalid_value('NA', {'missing_values': ['NA', '-999']}) is None


def test_correct_invalid_value_number():
    assert \
        correct_invalid_value(-999, {'missing_values': ['NA', '-999']}) is None


def test_correct_invalid_value_exception():
    assert correct_invalid_value(-999, {}) == -999


def test_create_db_statement():
    """Test creating the create database SQL statement."""
    assert test_engine.create_db_statement() == 'CREATE DATABASE test_abc'


def test_database_name():
    """Test creating database name."""
    assert test_engine.database_name() == 'test_abc'


def test_drop_statement():
    """Test the creation of drop statements."""
    assert test_engine.drop_statement(
        'TABLE', 'tablename') == "DROP TABLE IF EXISTS tablename"


def test_extract_values_fixed_width():
    """Test extraction of values from line of fixed width data."""
    test_engine.table.fixed_width = [5, 2, 2, 3, 4]
    assert test_engine.extract_fixed_width('abc  1 2 3  def ') == [
        'abc', '1', '2', '3', 'def']


def test_find_file_absent():
    """Test if find_file() properly returns false if no file is present."""
    assert test_engine.find_file('missingfile.txt') is False


def test_format_insert_value_int():
    """Test formatting of values for insert statements."""
    assert test_engine.format_insert_value(42, 'int') == 42


def test_format_insert_value_double():
    """Test formatting of values for insert statements."""
    assert test_engine.format_insert_value(26.22, 'double') == 26.22


def test_format_insert_value_string_simple():
    """Test formatting of values for insert statements."""
    test_str = "simple text"
    assert test_engine.format_insert_value(test_str, 'char') == test_str


def test_format_insert_value_string_complex():
    """Test formatting of values for insert statements."""
    test_str = 'my notes: "have extra, stuff"'
    assert test_engine.format_insert_value(test_str, 'char') == test_str


def test_getmd5_lines():
    """Test md5 sum calculation given a line."""
    lines = ['a,b,c', '1,2,3', '4,5,6']
    exp_hash = 'ca471abda3ebd4ae8ce1b0814b8f470c'
    assert getmd5(data=lines, data_type='lines') == exp_hash


def test_getmd5_line_end():
    """Test md5 sum calculation given a line with end of line character."""
    lines_end = ['a,b,c\n', '1,2,3\n', '4,5,6\n']
    exp_hash = '0bec5bf6f93c547bc9c6774acaf85e1a'
    assert getmd5(data=lines_end, data_type='lines') == exp_hash


def test_getmd5_path():
    """Test md5 sum calculation given a path to data source."""
    data_file = create_file(['a,b,c', '1,2,3', '4,5,6'])
    exp_hash = '0bec5bf6f93c547bc9c6774acaf85e1a'
    assert getmd5(data=data_file, data_type='file') == exp_hash


def test_json2csv():
    """Test json2csv function.

    Creates a json file and tests the md5 sum calculation.
    """
    json_file = create_file([
        """[ {"User": "Alex", "Country": "US", "Age": "25"} ]"""],
        'output.json')

    output_json = json2csv(json_file, "output_json.csv",
                           header_values=["User", "Country", "Age"])
    obs_out = file_2list(output_json)
    os.remove(output_json)
    assert obs_out == ['User,Country,Age', 'Alex,US,25']


def test_is_empty_null_string():
    """Test for null string."""
    assert is_empty("")


def test_is_empty_empty_list():
    """Test for empty list."""
    assert is_empty([])


def test_is_empty_not_null_string():
    """Test for non-null string."""
    assert is_empty("not empty") == False


def test_is_empty_not_empty_list():
    """Test for not empty list."""
    assert is_empty(["not empty"]) == False
