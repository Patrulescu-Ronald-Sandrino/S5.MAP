package com.example.booksapp.navigation

import com.example.booksapp.view.Texts.Companion.ADD_BOOK_SCREEN
import com.example.booksapp.view.Texts.Companion.BOOKS_LIST_SCREEN
import com.example.booksapp.view.Texts.Companion.UPDATE_BOOK_SCREEN
import com.example.booksapp.view.Texts.Companion.VIEW_BOOK_SCREEN

sealed class Screen(val route: String) {
    object BookList: Screen(BOOKS_LIST_SCREEN)
    object AddBook: Screen(ADD_BOOK_SCREEN)
    object UpdateBook: Screen(UPDATE_BOOK_SCREEN)
    object ViewBook: Screen(VIEW_BOOK_SCREEN)
}
