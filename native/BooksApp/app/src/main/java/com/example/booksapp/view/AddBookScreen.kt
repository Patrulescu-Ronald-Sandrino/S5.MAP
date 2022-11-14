package com.example.booksapp.view

import androidx.compose.foundation.layout.*
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.TextField
import androidx.compose.material.TopAppBar
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.hilt.navigation.compose.hiltViewModel
import com.example.booksapp.domain.Book


@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AddBookScreen(
    viewModel: BooksViewModel = hiltViewModel(),
    navigateBack: () -> Unit
) {
    Scaffold(
        topBar = {
             TopAppBar(
                 title = { Text(text = "Add Book") },
                    navigationIcon = {
                        IconButton(onClick = navigateBack) {
                            Icon(
                                imageVector = Icons.Default.ArrowBack,
                                contentDescription = "Back"
                            )
                        }
                    }
             )
        },
        content = { padding ->
            AddBookContent(
                padding = padding,
                addBook = { book -> viewModel.addBook(book) },
                navigateBack = navigateBack,
            )
        }
    )
}

@Composable
fun AddBookContent(
    padding: PaddingValues,
    addBook: (book: Book) -> Unit,
    navigateBack: () -> Unit
) {
    var title by remember { mutableStateOf("") }
    var author by remember { mutableStateOf("") }
    var year by remember { mutableStateOf("") }
    var lent: Boolean? by remember { mutableStateOf(null) }
    val focusRequester = FocusRequester()

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(padding),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center,
    ) {
        TextField(
            value = title,
            onValueChange = { title = it },
            label = { Text(text = "Title...") },
            modifier = Modifier.focusRequester(focusRequester)
        )
        LaunchedEffect(Unit) { focusRequester.requestFocus() } // used to set the focus on the first TextField
    }
}