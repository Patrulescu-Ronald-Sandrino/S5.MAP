package com.example.booksapp.navigation

sealed class Screen(val route: String) {
    object BookList: Screen("Books")
    object AddBook: Screen("Add book")
    object UpdateBook: Screen("Update book")
    object ViewBook: Screen("View book")
}
