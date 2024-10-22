import tree_sitter
from tree_sitter import Language, Parser

import tree_sitter_python as ts_python
import tree_sitter_go as ts_go
import tree_sitter_java as ts_java
import tree_sitter_javascript as ts_js
import tree_sitter_rust as ts_r


class LanguageParser:
    def __init__(self):
        self.PY_LANGUAGE = Language(ts_python.language())
        self.GO_LANGUAGE = Language(ts_go.language())
        self.JAVA_LANGUAGE = Language(ts_java.language())
        self.JS_LANGUAGE = Language(ts_js.language())
        self.RUST_LANGUAGE = Language(ts_r.language())

        self.PYTHON_PARSER = Parser(self.PY_LANGUAGE)
        self.GO_PARSER = Parser(self.GO_LANGUAGE)
        self.JAVA_PARSER = Parser(self.JAVA_LANGUAGE)
        self.JS_PARSER = Parser(self.JS_LANGUAGE)
        self.RUST_PARSER = Parser(self.RUST_LANGUAGE)

    def python_paser(self, code) -> 'tree_sitter.Tree':
        tree = self.PYTHON_PARSER.parse(code.encode('utf-8'))
        return tree

    def go_paser(self, code) -> 'tree_sitter.Tree':
        tree = self.GO_PARSER.parse(code.encode('utf-8'))
        return tree

    def java_paser(self, code) -> 'tree_sitter.Tree':
        tree = self.JAVA_PARSER.parse(code.encode('utf-8'))
        return tree

    def js_paser(self, code) -> 'tree_sitter.Tree':
        tree = self.JS_PARSER.parse(code.encode('utf-8'))
        return tree

    def rust_paser(self, code) -> 'tree_sitter.Tree':
        tree = self.RUST_PARSER.parse(code.encode('utf-8'))
        return tree
