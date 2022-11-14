package com.example.booksapp.view.books_list

import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.Composable
import androidx.hilt.navigation.compose.hiltViewModel
import com.example.booksapp.view.BooksViewModel

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun BooksListScreen(
    viewModel: BooksViewModel = hiltViewModel(),
) {
    val books = viewModel.books;
    Scaffold {

    }
}