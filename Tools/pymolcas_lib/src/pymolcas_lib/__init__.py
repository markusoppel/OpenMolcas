from __future__ import absolute_import

import os

# import pkg_resources  # part of setuptools
# __version__ = pkg_resources.get_distribution("pymolcas").version


def export(func):
    if callable(func) and hasattr(func, '__name__'):
        globals()[func.__name__] = func
    try:
        __all__.append(func.__name__)
    except NameError:
        __all__ = [func.__name__]
    return func

# have to be imported after export definition

from pymolcas_lib import (molcas_aux, abstract_flow, emil_grammar, molcas_wrapper,
                          simpleeval, check_test, emil_parse,
                          python_parse, tee, pymolcas, write_molcasrc)

from pymolcas_lib.pymolcas import main, f
