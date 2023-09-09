module.exports = {
    env: {
        browser: true,
        es6: true,
        node: true,
    },
    extends: ['eslint:recommended', 'google', 'plugin:react/recommended'],
    parser: 'babel-eslint',
    parserOptions: {
        ecmaVersion: 2020,
        sourceType: 'module',
        ecmaFeatures: {
            jsx: true,
        },
    },
    rules: {
        'arrow-parens': [1, 'as-needed'],
        'indent': 0,
        "jsx-a11y/href-no-hash": "off",
        "jsx-a11y/anchor-is-valid": ["warn", { "aspects": ["invalidHref"] }]
        'max-len': [1, 88],
        'no-empty': 1,
        'no-invalid-this': 0,
        'no-unused-vars': 'warn',
        'operator-linebreak': 0,
        'object-curly-spacing': [1, 'always'],
        'react/no-unescaped-entities': 0,
        'react/prop-types': 1,
        'require-jsdoc': 0,
    },
};
