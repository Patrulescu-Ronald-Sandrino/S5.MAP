package com.example.booksapp.view

import androidx.compose.foundation.layout.*
import androidx.compose.material.Checkbox
import androidx.compose.material.TextField
import androidx.compose.material3.Button
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.example.booksapp.domain.Book

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ViewBookScreen(
    viewModel: BooksViewModel = hiltViewModel(),
    id: Int,
    navigateToUpdateBookScreen: () -> Unit,
    navigateBack: () -> Unit,
) {
    LaunchedEffect(Unit) {
        viewModel.getBook(id)
    }

    Scaffold(
        topBar = { TopBar("View book", navigateBack) },
        content = {
            ViewBookContent(
                padding = it,
                book = viewModel.book,
                navigateToUpdateBookScreen = navigateToUpdateBookScreen
            )
        }
    )
}

@Composable
fun ViewBookContent(
    padding: PaddingValues,
    book: Book,
    navigateToUpdateBookScreen: () -> Unit
) {
    Column(
        modifier = Modifier.fillMaxSize().padding(padding),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center,
    ) {
        TextFieldReadOnly(value = book.author, placeholder = "Author")
        Spacer(modifier = Modifier.height(8.dp))
        TextFieldReadOnly(value = book.title, placeholder = "Title")
        Spacer(modifier = Modifier.height(8.dp))
        TextFieldReadOnly(value = book.year.toString(), placeholder = "Year")
        Spacer(modifier = Modifier.height(8.dp))
        Row {
            Checkbox(checked = book.lent, enabled = false, onCheckedChange = {})
            Text(text = "Lent")
        }

        Button(onClick = navigateToUpdateBookScreen) {
            Text(text = "Update")
        }
    }
}


@Composable
fun TextFieldReadOnly(
    value: String,
    placeholder: String
) {
    TextField(
        value = value,
        readOnly = true,
        onValueChange = {},
        placeholder = { Text(placeholder) },
        textStyle = TextStyle(color = Color.Magenta)
    )
}