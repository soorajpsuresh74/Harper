from tree_sitter import Language, Parser, Tree

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

        self.parsers = {
            'python': Parser(self.PY_LANGUAGE),
            'go': Parser(self.GO_LANGUAGE),
            'java': Parser(self.JAVA_LANGUAGE),
            'javascript': Parser(self.JS_LANGUAGE),
            'rust': Parser(self.RUST_LANGUAGE)
        }

    def parse_code(self, language: str, code: str) -> Tree:
        if language in self.parsers:
            return self.parsers[language].parse(code.encode('utf-8'))
        else:
            raise ValueError(f"Unsupported language: {language}")